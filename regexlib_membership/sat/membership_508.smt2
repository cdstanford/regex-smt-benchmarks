;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = if\s[(][A-Za-z]*\s[=]\s
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "if\xD(K\xA= "
(define-fun Witness1 () String (seq.++ "i" (seq.++ "f" (seq.++ "\x0d" (seq.++ "(" (seq.++ "K" (seq.++ "\x0a" (seq.++ "=" (seq.++ " " "")))))))))
;witness2: "if (\u00A0=\u0085\u0085"
(define-fun Witness2 () String (seq.++ "i" (seq.++ "f" (seq.++ " " (seq.++ "(" (seq.++ "\xa0" (seq.++ "=" (seq.++ "\x85" (seq.++ "\x85" "")))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "i" (seq.++ "f" "")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "=" "=") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
