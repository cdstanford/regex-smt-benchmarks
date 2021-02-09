;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^1300\d{6}$)|(^1800|1900|1902\d{6}$)|(^0[2|3|7|8]{1}[0-9]{8}$)|(^13\d{4}$)|(^04\d{2,3}\d{6}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "04683658295"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "4" (seq.++ "6" (seq.++ "8" (seq.++ "3" (seq.++ "6" (seq.++ "5" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "5" ""))))))))))))
;witness2: "1800\u00B9\u00F3"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "\xb9" (seq.++ "\xf3" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "3" (seq.++ "0" (seq.++ "0" "")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))(re.union (re.union (re.++ (str.to_re "") (str.to_re (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "0" ""))))))(re.union (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "0" ""))))) (re.++ (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "2" "")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.union (re.range "2" "3")(re.union (re.range "7" "8") (re.range "|" "|")))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "3" "")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "4" "")))(re.++ ((_ re.loop 2 3) (re.range "0" "9"))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
