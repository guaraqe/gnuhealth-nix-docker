let
  pkgs = import ./nix;
  modules = pkgs.trytond-modules;
  trytond = pkgs.trytond (
    # Base modules
    map modules.mkBaseModule [
      {
        name = "account";
        version = "6.4.4";
      }
      {
        name = "company";
        version = "6.4.1";
      }
      {
        name = "country";
        version = "6.4.2";
      }
      {
        name = "currency";
        version = "6.4.2";
      }
      {
        name = "party";
        version = "6.4.2";
      }
      {
        name = "product";
        version = "6.4.1";
      }
    ] ++
    # GNUHealth modules
    map (modules.mkHealthModule "4.0.4") [
      "health"
      #"health_archives"
      #"health_caldav"
      #"health_calendar"
      #"health_contact_tracing"
      #"health_crypto"
      #"health_crypto_lab"
      #"health_dentistry"
      #"health_disability"
      #"health_ems"
      #"health_federation"
      #"health_genetics"
      #"health_genetics_uniprot"
      #"health_gyneco"
      #"health_history"
      #"health_icd10"
      #"health_icd10pcs"
      #"health_icd11"
      #"health_icd9procs"
      #"health_icpm"
      #"health_icu"
      #"health_imaging"
      #"health_inpatient"
      #"health_inpatient_calendar"
      #"health_insurance"
      #"health_iss"
      #"health_lab"
      #"health_lifestyle"
      #"health_mdg6"
      #"health_ntd"
      #"health_ntd_chagas"
      #"health_ntd_dengue"
      #"health_nursing"
      #"health_ophthalmology"
      #"health_orthanc"
      #"health_pediatrics"
      #"health_pediatrics_growth_charts"
      #"health_pediatrics_growth_charts_who"
      #"health_profile"
      #"health_qrcodes"
      #"health_reporting"
      #"health_services"
      #"health_services_imaging"
      #"health_services_lab"
      #"health_socioeconomics"
      #"health_stock"
      #"health_surgery"
      #"health_webdav3_server"
      #"health_who_essential_medicines"
    ]
  );

in
  trytond
