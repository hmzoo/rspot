const setLed= (v)=>{
  return {
    type: "SET_LED",
    result:{led:v}
  };
}

const setVal= (v)=>{
  return {
    type: "SET_VAL",
    result:{val:v}
  };
}

const setInt= (v)=>{
  return {
    type: "SET_INT",
    result:{int:v}
  };
}



export {setLed,setVal,setInt};
