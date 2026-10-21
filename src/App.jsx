
import { useAuth0 } from '@auth0/auth0-react'

function App() {
  const {
    loginWithRedirect,
    logout,
    isAuthenticated,
    isLoading,
    user
  } = useAuth0()

  if (isLoading) {
    return <h2>Loading...</h2>
  }

  return (
    <div style={{
      textAlign: 'center',
      marginTop: '100px',
      fontFamily: 'Arial'
    }}>
      <h1>Identity as a Service (IDaaS)</h1>
      <h2>Login using Auth0</h2>

      {!isAuthenticated ? (
        <button onClick={() => loginWithRedirect()}>
          Login
        </button>
      ) : (
        <>
          <h3>Welcome, {user.name}!</h3>
          <p>Email: {user.email}</p>

          <button onClick={() =>
            logout({
              logoutParams: {
                returnTo: window.location.origin
              }
            })
          }>
            Logout
          </button>
        </>
      )}
    </div>
  )
}

export default App
