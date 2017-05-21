import React from 'react';

export default({datas,inc}) => (
    <div >
      {datas.name}<br/><small>{datas.cpt}</small><br/><button className='btn' onClick={inc}>INC</button>
    </div>
)
