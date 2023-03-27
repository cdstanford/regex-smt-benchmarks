;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.{4,8}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "*\u0092>\u0083\u00CD\x3U\x12"
(define-fun Witness1 () String (str.++ "*" (str.++ "\u{92}" (str.++ ">" (str.++ "\u{83}" (str.++ "\u{cd}" (str.++ "\u{03}" (str.++ "U" (str.++ "\u{12}" "")))))))))
;witness2: "h\u00D2\u00D4\u00872"
(define-fun Witness2 () String (str.++ "h" (str.++ "\u{d2}" (str.++ "\u{d4}" (str.++ "\u{87}" (str.++ "2" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 8) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
