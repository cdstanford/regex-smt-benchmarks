;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\([0-9]{3}\)\s?[0-9]{3}(-|\s)?[0-9]{4}$|^[0-9]{3}-?[0-9]{3}-?[0-9]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(239)\u0085808\xD9298"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "2" (seq.++ "3" (seq.++ "9" (seq.++ ")" (seq.++ "\x85" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "8" "")))))))))))))))
;witness2: "(897)969\u00A09169"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ ")" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "\xa0" (seq.++ "9" (seq.++ "1" (seq.++ "6" (seq.++ "9" ""))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
