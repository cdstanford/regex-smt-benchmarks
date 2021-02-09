;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0)44[\s]{0,1}[\-]{0,1}[\s]{0,1}2[\s]{0,1}[1-9]{1}[0-9]{6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "044 -2\x91845888"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "4" (seq.++ "4" (seq.++ " " (seq.++ "-" (seq.++ "2" (seq.++ "\x09" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "8" "")))))))))))))))
;witness2: "044-\xB2\u00855018458"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "4" (seq.++ "4" (seq.++ "-" (seq.++ "\x0b" (seq.++ "2" (seq.++ "\x85" (seq.++ "5" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "5" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (str.to_re (seq.++ "4" (seq.++ "4" "")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "2" "2")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
