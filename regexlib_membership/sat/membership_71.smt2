;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\,?[0-9]{2,3})*)(?<dec>\.)(?<postdec>[0-9]*)?$)|(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\.?[0-9]{2,3})*)(?<dec>\,)(?<postdec>[0-9]*)?$)|(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\'?[0-9]{2,3})*)(?<dec>\.)(?<postdec>[0-9]*)?$)|(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\,[0-9]{2,3})*)(?<dec>\.)(?<postdec>[0-9]*)?$)|(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\ [0-9]{2,3})*)(?<dec>\,)(?<postdec>[0-9]*)?$)|(?:^(?<sign>[+-]?)(?<predec>[0-9]{1,3}(?:\'?[0-9]{2,3})*)(?<dec>\,)(?<postdec>[0-9]*)?$))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+8,8"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "8" (seq.++ "," (seq.++ "8" "")))))
;witness2: "+9,19."
(define-fun Witness2 () String (seq.++ "+" (seq.++ "9" (seq.++ "," (seq.++ "1" (seq.++ "9" (seq.++ "." "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.opt (re.range "," ",")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.opt (re.range "." ".")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "," ",")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.opt (re.range "'" "'")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range " " " ") ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "," ",")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.opt (re.range "'" "'")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.++ (re.range "," ",")(re.++ (re.opt (re.* (re.range "0" "9"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
