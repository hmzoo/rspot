const initialState = {
  val:0,
  led:0,
  int:1
};

export default function(state =initialState, action) {

    switch (action.type) {
        case 'SET_LED':
            return Object.assign({}, state, action.result);
        case 'SET_VAL':
            return Object.assign({}, state, action.result);
        case 'SET_INT':
            return Object.assign({}, state, action.result);

        default:
            return state
    }
}
