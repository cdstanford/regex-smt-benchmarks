;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z]{1}[a-zA-Z]*[\s]{0,1}[a-zA-Z])+([\s]{0,1}[a-zA-Z]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "q\u00A0cnk"
(define-fun Witness1 () String (seq.++ "q" (seq.++ "\xa0" (seq.++ "c" (seq.++ "n" (seq.++ "k" ""))))))
;witness2: ")Zmhy M"
(define-fun Witness2 () String (seq.++ ")" (seq.++ "Z" (seq.++ "m" (seq.++ "h" (seq.++ "y" (seq.++ " " (seq.++ "M" ""))))))))

(assert (= regexA (re.++ (re.+ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
