;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([\r\n ]*//[^\r\n]*)+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Y\xD  \xA//\u00D0\u00E7"
(define-fun Witness1 () String (str.++ "Y" (str.++ "\u{0d}" (str.++ " " (str.++ " " (str.++ "\u{0a}" (str.++ "/" (str.++ "/" (str.++ "\u{d0}" (str.++ "\u{e7}" ""))))))))))
;witness2: "//\u00FFA"
(define-fun Witness2 () String (str.++ "/" (str.++ "/" (str.++ "\u{ff}" (str.++ "A" "")))))

(assert (= regexA (re.+ (re.++ (re.* (re.union (re.range "\u{0a}" "\u{0a}")(re.union (re.range "\u{0d}" "\u{0d}") (re.range " " " "))))(re.++ (str.to_re (str.++ "/" (str.++ "/" ""))) (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}") (re.range "\u{0e}" "\u{ff}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
