;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<field1>[^,]+),(?<field2>[^,]+),(?<field3>[^,]+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A5,\\u00F3\u00F4\x0,\u0099\u00A6U"
(define-fun Witness1 () String (str.++ "\u{a5}" (str.++ "," (str.++ "\u{5c}" (str.++ "\u{f3}" (str.++ "\u{f4}" (str.++ "\u{00}" (str.++ "," (str.++ "\u{99}" (str.++ "\u{a6}" (str.++ "U" "")))))))))))
;witness2: "1,\u00B5,N\'"
(define-fun Witness2 () String (str.++ "1" (str.++ "," (str.++ "\u{b5}" (str.++ "," (str.++ "N" (str.++ "'" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "+") (re.range "-" "\u{ff}"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
