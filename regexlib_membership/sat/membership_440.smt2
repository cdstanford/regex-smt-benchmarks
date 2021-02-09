;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+{1}|00)\s{0,1}([0-9]{3}|[0-9]{2})\s{0,1}\-{0,1}\s{0,1}([0-9]{2}|[1-9]{1})\s{0,1}\-{0,1}\s{0,1}([0-9]{8}|[0-9]{7})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+8129\u00A0- 96968999"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "8" (seq.++ "1" (seq.++ "2" (seq.++ "9" (seq.++ "\xa0" (seq.++ "-" (seq.++ " " (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))))))))))))))
;witness2: "+593\xC96\u00A08968573"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "5" (seq.++ "9" (seq.++ "3" (seq.++ "\x0c" (seq.++ "9" (seq.++ "6" (seq.++ "\xa0" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "3" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "+" "+") (str.to_re (seq.++ "0" (seq.++ "0" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "1" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union ((_ re.loop 8 8) (re.range "0" "9")) ((_ re.loop 7 7) (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
