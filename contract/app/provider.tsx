
"use client";

import { ThirdwebProvider } from "thirdweb/react";
import { createThirdwebClient } from "thirdweb";

const CLIENTID = process.env.NEXT_PUBLIC_THIRDWEB_CLIENT_ID
export const client = createThirdwebClient({
  clientId:CLIENTID!,
});

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <ThirdwebProvider client={client}>
      {children}
    </ThirdwebProvider>
  );
}
