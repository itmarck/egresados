import * as jsPDF from 'jspdf';

const margen = 10;
const MARGEN = 15;
const MAXWIDTH = 210;
const MAXHEIGHT = 297;
const COLOR = {
  principal: '#424242',
  negro: '#000000',
  blanco: '#FFFFFF',
  texto: '#5B5B5B',
  textoClaro: '#8E8E8E',
  gris: '#EBEBEB'
};
const SIZES = {
  sidebar: 70
};

var doc = new jsPDF();

function sidebar() {
  doc.setFillColor(COLOR.principal);
  doc.rect(0, 0, SIZES.sidebar, MAXHEIGHT, 'F');
}

function subtituloSidebar(texto, y) {
  doc
    .setFontSize(14)
    .setTextColor(COLOR.blanco)
    .setFontStyle('bold')
    .text(texto.toUpperCase(), MARGEN, y);
}

function datosSidebar(datos = [], y) {
  y += 8;
  for (let i = 0; i < datos.length; i++) {
    doc
      .setFontSize(10)
      .setTextColor(COLOR.blanco)
      .setFontStyle('normal')
      .text(datos[i], MARGEN, y, { maxWidth: SIZES.sidebar - MARGEN * 2 });
    y += 6;
  }
}

function tituloPrincipal(texto) {
  doc
    .setFontSize(24)
    .setTextColor(COLOR.principal)
    .setFontStyle('bold')
    .text(texto.toUpperCase(), SIZES.sidebar + margen, MARGEN + 5, {
      baseline: 'top'
    });
}

function subtituloPrincipal(texto) {
  doc
    .setFontSize(12)
    .setTextColor(COLOR.principal)
    .setFontStyle('normal')
    .text(texto.toUpperCase(), SIZES.sidebar + margen, MARGEN + 16, {
      baseline: 'top'
    });
}

function subtituloSecundario(texto, datos, y) {
  doc.setFillColor(COLOR.gris);
  doc.rect(
    SIZES.sidebar + margen,
    y,
    MAXWIDTH - SIZES.sidebar - margen - MARGEN,
    8,
    'F'
  );
  doc
    .setTextColor(COLOR.principal)
    .setFontStyle('bold')
    .text(texto, SIZES.sidebar + margen + 10, y + 4, {
      baseline: 'middle'
    });
  y += 20;
  colocarDatos(datos, y);
  return y;
}

function colocarDatos(datos, y) {
  for (let i = 0; i < datos.length; i++) {
    doc
      .setFontSize(12)
      .setTextColor(COLOR.texto)
      .setFontStyle('bold')
      .text(datos[i].fecha, SIZES.sidebar + margen + 10, y);
    doc.text(datos[i].centro, SIZES.sidebar + margen + 40, y);
    doc.setFontSize(10).setFontStyle('italic');
    doc
      .setTextColor(COLOR.textoClaro)
      .text(datos[i].cargo, SIZES.sidebar + margen + 40, y + 6);
    doc
      .setFontStyle('normal')
      .setFontSize(8)
      .text(datos[i].tiempo, SIZES.sidebar + margen + 10, y + 4);
    doc
      .setFontSize(10)
      .setTextColor(COLOR.texto)
      .text(datos[i].descripcion, SIZES.sidebar + margen + 40, y + 12, {
        maxWidth: MAXWIDTH - SIZES.sidebar - margen - 40 - MARGEN
      });
    y += 30;
  }
}

export function blancoNegro(datos) {
  init();

  // Sidebar
  sidebar();
  subtituloSidebar('CONTACTO', SIZES.sidebar);
  datosSidebar(datos.contacto, SIZES.sidebar);

  // Main
  tituloPrincipal(datos.nombre);
  subtituloPrincipal(datos.titulo);

  subtituloSecundario('EXPERIENCIA', datos.experiencia, 50);

  save();
}

function init() {
  doc.setFont('helvetica', 'normal');
}

function save() {
  doc.save('cv.pdf');
}
