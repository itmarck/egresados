import { url } from './config';

export async function get(peticion) {
  let res = await fetch(url + peticion);
  return res.json();
}

export async function post(peticion, datos) {
  let res = await fetch(url + peticion, {
    method: 'POST',
    body: JSON.stringify(datos),
    headers: {
      'Content-Type': 'application/json'
    }
  });
  return res.json();
}

export async function put(peticion, datos) {
  let res = await fetch(url + peticion, {
    method: 'PUT',
    body: JSON.stringify(datos),
    headers: {
      'Content-Type': 'application/json'
    }
  });
  return res.json();
}

export function hash(string) {
  return string.split('').reduce(function(a, b) {
    a = (a << 5) - a + b.charCodeAt(0);
    return a & a;
  }, 0);
}
