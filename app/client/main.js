import React from 'react';
import ReactDOM from 'react-dom';
import {Provider} from 'react-redux';
import {createStore} from 'redux';

import Sio from 'socket.io-client';

import App from './views';

import reducers from './reducers';
let store = createStore(reducers);

import {setProfilName, incProfilCpt} from './actions/profil.js';
store.dispatch(setProfilName("My name"));
store.dispatch(incProfilCpt());



import {setVal, setLed, setInt} from './actions/esp.js';
let socket = Sio.connect();
socket.on('connect', (data) => {
    socket.emit('join', 'Hello World from client');
    console.log("connected to Sockect io");
});

socket.on('VA', (data) => {
    //console.log('VA', data);
    store.dispatch(setVal(data.value));
});

socket.on('DS', (data) => {
    //console.log('DS', data);
    if (data.id == "1") {
        store.dispatch(setInt(data.value));
    }
    if (data.id == "2") {
        store.dispatch(setLed(data.value));
    }
});

let setledup = ()=>{
  console.log('SD');
  socket.emit('SD', {id:'2',value:'0'});
}
let setleddown = ()=>{
  socket.emit('SD', {id:'2',value:'1'});
}

ReactDOM.render(
    <Provider store={store}>
      <App setledup={setledup} setleddown={setleddown}/></Provider>, document.getElementById('app'));
