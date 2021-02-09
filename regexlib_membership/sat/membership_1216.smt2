;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*-?(\d*\.)?([0-2])?[0-9]:([0-5])?[0-9]:([0-5])?[0-9](\.[0-9]{1,7})?\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0085-30.22:0:26.9\u0085\u0085"
(define-fun Witness1 () String (seq.++ "\x85" (seq.++ "-" (seq.++ "3" (seq.++ "0" (seq.++ "." (seq.++ "2" (seq.++ "2" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "2" (seq.++ "6" (seq.++ "." (seq.++ "9" (seq.++ "\x85" (seq.++ "\x85" "")))))))))))))))))
;witness2: "4:5:40.8 "
(define-fun Witness2 () String (seq.++ "4" (seq.++ ":" (seq.++ "5" (seq.++ ":" (seq.++ "4" (seq.++ "0" (seq.++ "." (seq.++ "8" (seq.++ " " ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.++ (re.* (re.range "0" "9")) (re.range "." ".")))(re.++ (re.opt (re.range "0" "2"))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 7) (re.range "0" "9"))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
