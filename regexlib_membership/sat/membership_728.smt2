;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\{1}[2-9]{1}[0-9]{2}\){1}[ ]?[2-9]{1}[0-9]{2}(-| )?[0-9]{4}|[2-9]{1}[0-9]{2}[ ]{1}[2-9]{1}[0-9]{2}[ ]{1}[0-9]{4}|[2-9]{1}[0-9]{2}[2-9]{1}[0-9]{6}|[2-9]{1}[0-9]{2}-{1}[2-9]{1}[0-9]{2}-{1}[0-9]{4}){1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "599 727 0589"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "7" (seq.++ "2" (seq.++ "7" (seq.++ " " (seq.++ "0" (seq.++ "5" (seq.++ "8" (seq.++ "9" "")))))))))))))
;witness2: "{1}655)5898398"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "1" (seq.++ "}" (seq.++ "6" (seq.++ "5" (seq.++ "5" (seq.++ ")" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "{" (seq.++ "1" (seq.++ "}" ""))))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ (re.opt (re.range " " " "))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))(re.union (re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "2" "9") ((_ re.loop 6 6) (re.range "0" "9"))))) (re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
