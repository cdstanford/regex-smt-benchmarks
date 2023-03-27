;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((Sir|Dr.|Mr.|Mrs.|Ms.|Rev.){1}[ ]?)?([A-Z]{1}[.]{1}([A-Z]{1}[.]{1})?|[A-Z]{1}[a-z]{1,}|[A-Z]{1}[a-z]{1,}[-]{1}[A-Z]{1}[a-z]{1,}|[A-Z]{1}[a-z]{0,}[ ]{1}[A-Z]{1}[a-z]{0,}){1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Sir Fv"
(define-fun Witness1 () String (str.++ "S" (str.++ "i" (str.++ "r" (str.++ " " (str.++ "F" (str.++ "v" "")))))))
;witness2: "Rev\x1FSzz-Gszb"
(define-fun Witness2 () String (str.++ "R" (str.++ "e" (str.++ "v" (str.++ "\u{1f}" (str.++ "S" (str.++ "z" (str.++ "z" (str.++ "-" (str.++ "G" (str.++ "s" (str.++ "z" (str.++ "b" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (str.to_re (str.++ "S" (str.++ "i" (str.++ "r" ""))))(re.union (re.++ (str.to_re (str.++ "D" (str.++ "r" ""))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.union (re.++ (str.to_re (str.++ "M" (str.++ "r" ""))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.union (re.++ (str.to_re (str.++ "M" (str.++ "r" (str.++ "s" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.union (re.++ (str.to_re (str.++ "M" (str.++ "s" ""))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.++ (str.to_re (str.++ "R" (str.++ "e" (str.++ "v" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))) (re.opt (re.range " " " "))))(re.++ (re.union (re.++ (re.range "A" "Z")(re.++ (re.range "." ".") (re.opt (re.++ (re.range "A" "Z") (re.range "." ".")))))(re.union (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))(re.union (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))) (re.++ (re.range "A" "Z")(re.++ (re.* (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.* (re.range "a" "z"))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
