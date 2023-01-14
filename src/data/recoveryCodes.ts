import Alpine from 'alpinejs';

type DataType = {
  $refs: RefsType;
  $store: StoreType;
};

type RefsType = {
  codeList: HTMLUListElement;
};

type StoreType = {
  recoveryCodes: {
    downloadFileDate: string;
    downloadFileDescription: string;
    downloadFileHeader: string;
    downloadFileName: string;
  };
};

document.addEventListener('alpine:init', () => {
  Alpine.data('recoveryCodes', function (this: DataType) {
    const { codeList } = this.$refs;
    const { downloadFileDate, downloadFileDescription, downloadFileHeader, downloadFileName } =
      this.$store.recoveryCodes;

    const date = new Date().toLocaleString(navigator.language);

    const codeElements = codeList.getElementsByTagName('li');
    const codes = Array.from(codeElements)
      .map((codeElement) => codeElement.innerText)
      .join('\n');

    return {
      copy: () => navigator.clipboard.writeText(codes),
      download: () => {
        const element = document.createElement('a');
        const text = `${downloadFileHeader}\n\n${codes}\n\n${downloadFileDescription}\n\n${downloadFileDate} ${date}`;

        element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
        element.setAttribute('download', `${downloadFileName}.txt`);
        element.click();
      },
      print: () => {
        const codeListHTML = codeList.innerHTML;
        const styles = 'div { font-family: monospace; list-style-type: none }';
        const content = `<html><style>${styles}</style><body><title>${downloadFileName}</title><p>${downloadFileHeader}</p><div>${codeListHTML}</div><p>${downloadFileDescription}</p><p>${downloadFileDate} ${date}</p></body></html>`;

        const printWindow = window.open();

        if (printWindow) {
          printWindow.document.write(content);
          printWindow.print();
          printWindow.close();
        }
      },
    };
  });
});
