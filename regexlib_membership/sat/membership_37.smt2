;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<field1>[^,]+),(?<field2>[^,]+),(?<field3>[^,]+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009E\u0097\u0094\u00FD\u00C2\x12,\u009E\x16,d\u00F6"
(define-fun Witness1 () String (str.++ "\u{9e}" (str.++ "\u{97}" (str.++ "\u{94}" (str.++ "\u{fd}" (str.++ "\u{c2}" (str.++ "\u{12}" (str.++ "," (str.++ "\u{9e}" (str.++ "\u{16}" (str.++ "," (str.++ "d" (str.++ "\u{f6}" "")))))))))))))
;witness2: "\u0094_\u00AD,/,-E"
(define-fun Witness2 () String (str.++ "\u{94}" (str.++ "_" (str.++ "\u{ad}" (str.++ "," (str.++ "/" (str.++ "," (str.++ "-" (str.++ "E" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
