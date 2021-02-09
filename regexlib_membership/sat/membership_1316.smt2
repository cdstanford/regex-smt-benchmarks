;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d(\x20)\d{2}(\x20)\d{2}(\x20)\d{2}(\x20)\d{3}(\x20)\d{3}((\x20)\d{2}|))|(\d\d{2}\d{2}\d{2}\d{3}\d{3}(\d{2}|)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "458895892839210"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "2" (seq.++ "1" (seq.++ "0" ""))))))))))))))))
;witness2: "880675990769478"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "6" (seq.++ "7" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "7" (seq.++ "6" (seq.++ "9" (seq.++ "4" (seq.++ "7" (seq.++ "8" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re ""))))))))))))) (re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
