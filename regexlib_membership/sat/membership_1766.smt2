;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{1,2}[0-9]{1,2}|[A-Z]{3}|[A-Z]{1,2}[0-9][A-Z])( |-)[0-9][A-Z]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ZX0X 6SK\x1A\u00C3\u00D7"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "X" (seq.++ "0" (seq.++ "X" (seq.++ " " (seq.++ "6" (seq.++ "S" (seq.++ "K" (seq.++ "\x1a" (seq.++ "\xc3" (seq.++ "\xd7" ""))))))))))))
;witness2: "PBU-2WZ\u00A8\u008F\x1D"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "B" (seq.++ "U" (seq.++ "-" (seq.++ "2" (seq.++ "W" (seq.++ "Z" (seq.++ "\xa8" (seq.++ "\x8f" (seq.++ "\x1d" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 1 2) (re.range "A" "Z")) ((_ re.loop 1 2) (re.range "0" "9")))(re.union ((_ re.loop 3 3) (re.range "A" "Z")) (re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.range "0" "9") (re.range "A" "Z")))))(re.++ (re.union (re.range " " " ") (re.range "-" "-"))(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.range "A" "Z"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
