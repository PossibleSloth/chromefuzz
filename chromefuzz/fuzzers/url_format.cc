#include <stddef.h>
#include <stdint.h>

#include "url/gurl.h"
#include "components/url_formatter/url_formatter.h"


extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) {
    GURL url(std::string(reinterpret_cast<const char*>(data), size));
    base::string16 result = url_formatter::FormatUrl(
            failed_url,
            url_formatter::kFormatUrlOmitNothing, //https://cs.chromium.org/chromium/src/components/omnibox/browser/autocomplete_match.cc?l=567 
            net::UnescapeRule::NORMAL, // https://cs.chromium.org/chromium/src/net/base/escape.h?l=64
            nullptr, 
            nullptr, 
            nullptr);
    return 0;
}
