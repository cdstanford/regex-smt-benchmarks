;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0?[1-9]|[12][1-9]|3[01])\.(0?[13578]|1[02])\.20[0-9]{2}|(0?[1-9]|[12][1-9]|30)\.(0?[13456789]|1[012])\.20[0-9]{2}|(0?[1-9]|1[1-9]|2[0-8])\.(0?[123456789]|1[012])\.20[0-9]{2}|(0?[1-9]|[12][1-9])\.(0?[123456789]|1[012])\.20(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9.11.2084"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "1" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "4" ""))))))))))
;witness2: "03.10.2000"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "3" (seq.++ "." (seq.++ "1" (seq.++ "0" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "0" (seq.++ "0" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "1" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (str.to_re (seq.++ "." (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "1" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (str.to_re (seq.++ "." (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "1" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (str.to_re (seq.++ "." (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "1" "9")))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (str.to_re (seq.++ "." (seq.++ "2" (seq.++ "0" "")))) (re.union (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "9" (seq.++ "2" ""))) (str.to_re (seq.++ "9" (seq.++ "6" "")))))))))))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
