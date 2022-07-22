module LocalesHelper
  def system_locales
    [
      { code: "km", label: I18n.t("user.locale_km"), image: "khmer.png" },
      { code: "en", label: I18n.t("user.locale_en"), image: "english.png" }
    ]
  end
end
