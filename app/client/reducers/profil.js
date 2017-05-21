const initialState = {
  name: '',
  cpt:0
};

export default function(state =initialState, action) {

    switch (action.type) {
        case 'SET_PROFIL_NAME':
            return Object.assign({}, state, action.profil);
        case 'INC_PROFIL_CPT':
            return Object.assign({}, state, {cpt:state.cpt+1});

        default:
            return state
    }
}
