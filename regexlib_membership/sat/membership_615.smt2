;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (</?\w*[^<>]*>)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "</\x12>\u00A4"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "/" (seq.++ "\x12" (seq.++ ">" (seq.++ "\xa4" ""))))))
;witness2: "<\u009F>e"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\x9f" (seq.++ ">" (seq.++ "e" "")))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x00" ";")(re.union (re.range "=" "=") (re.range "?" "\xff")))) (re.range ">" ">")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
