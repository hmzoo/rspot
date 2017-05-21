import React from 'react';

export default({datas,leddown,ledup}) => (
    <div >
      <div className="box box-round grid m">
        <div className="grid-item 1/3"></div>
        <div className="grid-item 1/3 tc p"><h2>VAL:{datas.val}</h2></div>
        <div className="grid-item 1/3"></div>
      </div>
      <div className="box box-round grid m">
        <div className="grid-item 1/3"></div>
        <div className="grid-item 1/3 tc p"><h2>LED:{datas.led}</h2></div>
        <div className="grid-item 1/3 tc p"><button className="btn btn-lg btn-primary" onMouseDown={leddown} onMouseUp={ledup} onTouchStart={leddown} onTouchEnd={ledup}>TEST</button></div>
      </div>
      <div className="box box-round grid m">
        <div className="grid-item 1/3"></div>
        <div className="grid-item 1/3 tc p"><h2>INT:{datas.int}</h2></div>
        <div className="grid-item 1/3"></div>
      </div>


    </div>
)
