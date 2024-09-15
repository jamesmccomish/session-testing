import '../App.css'

import { useState } from 'react'
import { useAccount, useConnect } from "wagmi";
import { GrantPermissions } from "./grant-permissions";

import WalletComponent from "./wallet-component";

function App() {
  // TODO replace with counter from contract
  const [count, setCount] = useState(0)

  const account = useAccount();
  const { connectors, connect } = useConnect();

  console.log({ account });

  const login = async () => {
    connect({ connector: connectors[0] });
  };

  return (
    <div className="min-h-screen bg-cover bg-center">
      <h1>Base Session Key Example</h1>
      <div className="flex justify-end">
        {account.address ? (
          <div >
            <WalletComponent />
            <GrantPermissions />
          </div>
        )
          :
          (
            <button
              onClick={login}
              type="button"
              className="bg-purple-500 text-white text-xl text-bold text-black px-4 py-2 rounded"
            >
              Log in
            </button>
          )}
      </div>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>
    </div>
  )
}

export default App
