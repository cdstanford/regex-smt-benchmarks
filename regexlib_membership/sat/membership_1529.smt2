;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<field1>[^,]+),(?<field2>[^,]+),(?<field3>[^,]+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A5,\\u00F3\u00F4\x0,\u0099\u00A6U"
(define-fun Witness1 () String (seq.++ "\xa5" (seq.++ "," (seq.++ "\x5c" (seq.++ "\xf3" (seq.++ "\xf4" (seq.++ "\x00" (seq.++ "," (seq.++ "\x99" (seq.++ "\xa6" (seq.++ "U" "")))))))))))
;witness2: "1,\u00B5,N\'"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "," (seq.++ "\xb5" (seq.++ "," (seq.++ "N" (seq.++ "'" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
