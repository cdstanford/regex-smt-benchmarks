;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^0[78][2347][0-9]{7})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0743889382\x1"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "7" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "\x01" ""))))))))))))
;witness2: "0825559289\u00D3\u00DA\u00DF|\u00AA)"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "5" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "\xd3" (seq.++ "\xda" (seq.++ "\xdf" (seq.++ "|" (seq.++ "\xaa" (seq.++ ")" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.range "7" "8")(re.++ (re.union (re.range "2" "4") (re.range "7" "7")) ((_ re.loop 7 7) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
