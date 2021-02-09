;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-f]{4}\.[0-9a-f]{4}\.[0-9a-f]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "5fc9.0c9f.398e"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "f" (seq.++ "c" (seq.++ "9" (seq.++ "." (seq.++ "0" (seq.++ "c" (seq.++ "9" (seq.++ "f" (seq.++ "." (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "e" "")))))))))))))))
;witness2: "1539.9c8f.a9c8"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "5" (seq.++ "3" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "c" (seq.++ "8" (seq.++ "f" (seq.++ "." (seq.++ "a" (seq.++ "9" (seq.++ "c" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f")))(re.++ (re.range "." ".")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f")))(re.++ (re.range "." ".") ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
