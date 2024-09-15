import React, { useState } from 'react'
import {
  useGrantPermissions,
} from "wagmi/experimental";
import { useAccount } from "wagmi";
import {
  createCredential,
  P256Credential
} from "webauthn-p256";
import { Hex, toFunctionSelector } from "viem";
import { PERMISSIONED_COUNTER_CONTRACT_ADDRESS } from '../constants/PermissionedCounterContract';

export const Permissions = () => {
  const { address } = useAccount();
  const { grantPermissionsAsync } = useGrantPermissions();

  const [permissionsContext, setPermissionsContext] = useState<
    Hex | undefined
  >();
  const [credential, setCredential] = useState<
    undefined | P256Credential<"cryptokey">
  >();

  const grantPermissions = async (allowance: bigint, period: number) => {
    if (address) {
      const newCredential = await createCredential({ type: "cryptoKey" });
      const response = await grantPermissionsAsync({
        permissions: [
          {
            address: address,
            chainId: 84532,
            expiry: 17218875770,
            signer: {
              type: "key",
              data: {
                type: "secp256r1",
                publicKey: newCredential.publicKey,
              },
            },
            permissions: [
              {
                type: "native-token-recurring-allowance",
                data: {
                  allowance: allowance,
                  start: Math.floor(Date.now() / 1000),
                  period: period,
                },
              },
              {
                type: "allowed-contract-selector",
                data: {
                  contract: PERMISSIONED_COUNTER_CONTRACT_ADDRESS,
                  selector: toFunctionSelector(
                    "permissionedCall(bytes calldata call)"
                  ),
                },
              },
            ],
          },
        ],
      });
      const context = response[0].context as Hex;
      setPermissionsContext(context);
      setCredential(newCredential);
    }
  };

  return (
    <div>
      {/* Grant persmission for 3 clicks over the next 30 seconds */}
      <button onClick={() => grantPermissions(3n, 30)}>Grant Permissions

      </button>
    </div>
  )
}