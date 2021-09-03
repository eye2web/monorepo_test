import * as React from 'react';
import { hot } from 'react-hot-loader';
import Watchlist from 'watchlist';

class App extends React.Component {
  render() {
    return (
      <div
        className='app'
        style={{ textAlign: 'center', backgroundColor: '#e0e0e0' }}
      >
        <h1>MMP</h1>
        <Watchlist />
      </div>
    );
  }
}

export default hot(module)(App);
