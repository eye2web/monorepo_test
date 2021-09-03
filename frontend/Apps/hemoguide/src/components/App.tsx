import * as React from 'react';
import { hot } from 'react-hot-loader';
import Watchlist from 'watchlist';

class App extends React.Component {
  render() {
    return (
      <div className='app' style={{ textAlign: 'center' }}>
        <h1>Hemoguide App</h1>
        <Watchlist />
      </div>
    );
  }
}

export default hot(module)(App);
