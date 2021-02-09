;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\.\.){1}/)*|(/){1})?(([a-zA-Z0-9]*)/)*([a-zA-Z0-9]*)+([.jpg]|[.gif])+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "p."
(define-fun Witness1 () String (seq.++ "p" (seq.++ "." "")))
;witness2: "/j"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "j" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.* (re.++ (str.to_re (seq.++ "." (seq.++ "." ""))) (re.range "/" "/"))) (re.range "/" "/")))(re.++ (re.* (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.range "/" "/")))(re.++ (re.+ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "f" "g")(re.union (re.range "i" "j") (re.range "p" "p"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
