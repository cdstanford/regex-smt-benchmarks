;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((Sir|Dr.|Mr.|Mrs.|Ms.|Rev.){1}[ ]?)?([A-Z]{1}[.]{1}([A-Z]{1}[.]{1})?|[A-Z]{1}[a-z]{1,}|[A-Z]{1}[a-z]{1,}[-]{1}[A-Z]{1}[a-z]{1,}|[A-Z]{1}[a-z]{0,}[ ]{1}[A-Z]{1}[a-z]{0,}){1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Sir Fv"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "i" (seq.++ "r" (seq.++ " " (seq.++ "F" (seq.++ "v" "")))))))
;witness2: "Rev\x1FSzz-Gszb"
(define-fun Witness2 () String (seq.++ "R" (seq.++ "e" (seq.++ "v" (seq.++ "\x1f" (seq.++ "S" (seq.++ "z" (seq.++ "z" (seq.++ "-" (seq.++ "G" (seq.++ "s" (seq.++ "z" (seq.++ "b" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (str.to_re (seq.++ "S" (seq.++ "i" (seq.++ "r" ""))))(re.union (re.++ (str.to_re (seq.++ "D" (seq.++ "r" ""))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.union (re.++ (str.to_re (seq.++ "M" (seq.++ "r" ""))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.union (re.++ (str.to_re (seq.++ "M" (seq.++ "r" (seq.++ "s" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.union (re.++ (str.to_re (seq.++ "M" (seq.++ "s" ""))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.++ (str.to_re (seq.++ "R" (seq.++ "e" (seq.++ "v" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))) (re.opt (re.range " " " "))))(re.++ (re.union (re.++ (re.range "A" "Z")(re.++ (re.range "." ".") (re.opt (re.++ (re.range "A" "Z") (re.range "." ".")))))(re.union (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))(re.union (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))) (re.++ (re.range "A" "Z")(re.++ (re.* (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.* (re.range "a" "z"))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
