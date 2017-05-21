const setProfilName= (name)=>{
  return {
    type: "SET_PROFIL_NAME",
    profil:{name:name}
  };
}

const incProfilCpt= ()=>{
  return {
    type: "INC_PROFIL_CPT"
  };
}

export {setProfilName,incProfilCpt};
