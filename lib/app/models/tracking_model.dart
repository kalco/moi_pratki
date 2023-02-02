class TrackingModel {
  List<TrackingData> data = [];

  TrackingModel(this.data);

  TrackingModel.fromJson(Map<String, dynamic> json) {
    data = TrackingData.fromJson(json) as List<TrackingData>;

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = TrackingData().toJson();
    return data;
  }

}

class TrackingData {
  String? nRRDERGESES;
  String? eMRI;
  String? pOSTAFILLIM;
  String? pOSTAFUND;
  String? dATAPERPUNIMIT;
  String? bRZAKL;
  String? lLOJIZAKL;
  String? bROTPR;
  String? dATUMDOSTAVUVAWE;
  String? zABELESKA;
  String? naslov;

  TrackingData(
      {this.nRRDERGESES,
      this.eMRI,
      this.pOSTAFILLIM,
      this.pOSTAFUND,
      this.dATAPERPUNIMIT,
      this.bRZAKL,
      this.lLOJIZAKL,
      this.bROTPR,
      this.dATUMDOSTAVUVAWE,
      this.zABELESKA,
      this.naslov});

  TrackingData.fromJson(Map<String, dynamic> json) {
    nRRDERGESES = json['NR_R_DERGESES'];
    eMRI = json['EMRI'];
    pOSTAFILLIM = json['POSTA_FILLIM'];
    pOSTAFUND = json['POSTA_FUND'];
    dATAPERPUNIMIT = json['DATA_PERPUNIMIT'];
    bRZAKL = json['BRZAKL'];
    lLOJIZAKL = json['LLOJIZAKL'] ?? "NA";
    bROTPR = json['BROTPR'] ?? "NA";
    dATUMDOSTAVUVAWE = json['DATUM_DOSTAVUVAWE'] ?? "NA";
    zABELESKA = json['ZABELESKA'];
    naslov = json['n'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NR_R_DERGESES'] = nRRDERGESES;
    data['EMRI'] = eMRI;
    data['POSTA_FILLIM'] = pOSTAFILLIM;
    data['POSTA_FUND'] = pOSTAFUND;
    data['DATA_PERPUNIMIT'] = dATAPERPUNIMIT;
    data['BRZAKL'] = bRZAKL;
    data['LLOJIZAKL'] = lLOJIZAKL;
    data['BROTPR'] = bROTPR;
    data['DATUM_DOSTAVUVAWE'] = dATUMDOSTAVUVAWE;
    data['ZABELESKA'] = zABELESKA;
    data['n'] = naslov;
    return data;
  }
}
