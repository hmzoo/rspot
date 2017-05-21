import React, { Component } from 'react';
import {connect} from 'react-redux';
import Profil from './profil';
import Esp from './esp';
import {setProfilName,incProfilCpt} from '../actions/profil.js';

class App extends Component {
  render() {
    return (

      <div className="App">
        <div className="wrapper tc"><h1>RSPOT</h1></div>


        <Esp datas={this.props.esp} ledup={this.props.setledup} leddown={this.props.setleddown}/>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
    return {
      profil: state.profil,
      esp: state.esp
    }
}

const mapDispatchToProps = (dispatch) => {
    return {
      inc: ()=>{dispatch(incProfilCpt());}

    }
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
