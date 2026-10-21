import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyCnuVlKBvnYONtIdDVcn",
  authDomain: "booklibrary-6251d.firebaseapp.com",
  projectId: "booklibrary-6251d",
  storageBucket: "booklibrary-6251d.firebasestorage.app",
  messagingSenderId: "124310131720",
  appId: "1:124310131720:web:66cc9b9a45baec7a08adbd"
};

const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);