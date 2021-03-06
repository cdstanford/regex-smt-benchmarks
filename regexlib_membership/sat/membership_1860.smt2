;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{4}\s{0,1}[a-zA-Z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1968qz"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "q" (seq.++ "z" "")))))))
;witness2: "9869Ay"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "A" (seq.++ "y" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
