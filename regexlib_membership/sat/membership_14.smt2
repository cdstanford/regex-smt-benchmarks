;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0*[0-1]?[0-9]{1,2}\.)|(0*((2[0-4][0-9])|(25[0-5]))\.)){3}((0*[0-1]?[0-9]{1,2})|(0*((2[0-4][0-9])|(25[0-5]))))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "11.099.9.6"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "." (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "6" "")))))))))))
;witness2: "0000255.247.8.19"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "7" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "1" (seq.++ "9" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.++ (re.* (re.range "0" "0"))(re.++ (re.opt (re.range "0" "1"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." ".")))) (re.++ (re.* (re.range "0" "0"))(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))) (re.range "." ".")))))(re.++ (re.union (re.++ (re.* (re.range "0" "0"))(re.++ (re.opt (re.range "0" "1")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.++ (re.* (re.range "0" "0")) (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
