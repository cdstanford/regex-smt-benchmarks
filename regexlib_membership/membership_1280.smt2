;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = urn:[a-z0-9]{1}[a-z0-9\-]{1,31}:[a-z0-9_,:=@;!'%/#\(\)\+\-\.\$\*\?]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "urn:rfc8:@@@ek4"
(define-fun Witness1 () String (str.++ "u" (str.++ "r" (str.++ "n" (str.++ ":" (str.++ "r" (str.++ "f" (str.++ "c" (str.++ "8" (str.++ ":" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "e" (str.++ "k" (str.++ "4" ""))))))))))))))))
;witness2: "}Kurn:8--:_@\u00B8\u00AC\u00C6"
(define-fun Witness2 () String (str.++ "}" (str.++ "K" (str.++ "u" (str.++ "r" (str.++ "n" (str.++ ":" (str.++ "8" (str.++ "-" (str.++ "-" (str.++ ":" (str.++ "_" (str.++ "@" (str.++ "\u{b8}" (str.++ "\u{ac}" (str.++ "\u{c6}" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "u" (str.++ "r" (str.++ "n" (str.++ ":" "")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ ((_ re.loop 1 31) (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.range ":" ":") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "%")(re.union (re.range "'" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "@")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
