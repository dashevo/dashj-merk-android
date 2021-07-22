use std::os::raw::{c_char};
use std::ffi::{CString, CStr};

#[allow(non_snake_case)]
pub mod android {
    extern crate jni;
    extern crate hex;
    use super::*;

    use self::jni::JNIEnv;
    use self::jni::objects::{JClass, JString, JObject, JMap};
    use self::jni::sys::{jstring, jbyteArray, jobject};
    use merk::{verify, execute_proof};
    //use merk::verify_query;
    use std::convert::TryInto;

    #[no_mangle]
    pub unsafe extern fn Java_org_dashj_merk_MerkVerifyProof_extractProofNative(env: JNIEnv, _: JClass, java_bytes: jbyteArray, java_map: jobject) {

        let bytes = env.convert_byte_array(java_bytes).expect("invalid bytes");
        println!("Parameters passed from Kotlin that were converted to Rust:");
        println!("bytes: {}", hex::encode(bytes.clone()));

        //let keys: Vec<u8> = key.iter().cloned().collect();
        let output = execute_proof(bytes.as_slice());

        match output  {
            Err(_) => {
                let error = output.err();
                println!("Error decoding json: {:?}", error);
            }
            Ok((hash, map)) => {
                let jmap = env.get_map(java_map.into()).unwrap();

                for key_value_pair in map.all() {
                    let key = key_value_pair.0;
                    let (exists, value) = key_value_pair.1;

                    let javaKey = env.byte_array_from_slice(&*key).unwrap();
                    let javaValue = env.byte_array_from_slice(value).unwrap();

                    jmap.put(JObject::from(javaKey), JObject::from(javaValue));
                };
            }
        }
    }
}
