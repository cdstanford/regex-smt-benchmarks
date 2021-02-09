;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4}((-)?(0[1-9]|1[0-2])((-)?(0[1-9]|[1-2][0-9]|3[0-1])(T(24:00(:00(\.[0]+)?)?|(([0-1][0-9]|2[0-3])(:)[0-5][0-9])((:)[0-5][0-9](\.[\d]+)?)?)((\+|-)(14:00|(0[0-9]|1[0-3])(:)[0-5][0-9])|Z))?)?)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6996-04-25"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "-" (seq.++ "0" (seq.++ "4" (seq.++ "-" (seq.++ "2" (seq.++ "5" "")))))))))))
;witness2: "84981108T20:54:49-11:45"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "1" (seq.++ "0" (seq.++ "8" (seq.++ "T" (seq.++ "2" (seq.++ "0" (seq.++ ":" (seq.++ "5" (seq.++ "4" (seq.++ ":" (seq.++ "4" (seq.++ "9" (seq.++ "-" (seq.++ "1" (seq.++ "1" (seq.++ ":" (seq.++ "4" (seq.++ "5" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.opt (re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.opt (re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))) (re.opt (re.++ (re.range "T" "T")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ ":" (seq.++ "0" (seq.++ "0" "")))))) (re.opt (re.++ (str.to_re (seq.++ ":" (seq.++ "0" (seq.++ "0" "")))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "0"))))))) (re.++ (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))) (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))))))))) (re.union (re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.union (str.to_re (seq.++ "1" (seq.++ "4" (seq.++ ":" (seq.++ "0" (seq.++ "0" "")))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))))) (re.range "Z" "Z")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
