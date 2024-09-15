import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

import { Hex, toFunctionSelector } from "viem";
import { useAccount, useConnect } from "wagmi";
import {
  useGrantPermissions,
} from "wagmi/experimental";
import {
  createCredential,
  P256Credential
} from "webauthn-p256";

function App() {
  const [count, setCount] = useState(0)

  const [permissionsContext, setPermissionsContext] = useState<
  Hex | undefined
>();
const [credential, setCredential] = useState<
  undefined | P256Credential<"cryptokey">
>();

const account = useAccount();
const { connectors, connect } = useConnect();
const { grantPermissionsAsync } = useGrantPermissions();


const login = async () => {
  connect({ connector: connectors[0] });
};

  return (
    <>
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  )
}

export default App
