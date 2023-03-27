;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^!~/&gt;&lt;\|/#%():;{}`_-]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\'"
(define-fun Witness1 () String (str.++ "'" ""))
;witness2: "\u0082"
(define-fun Witness2 () String (str.++ "\u{82}" ""))

(assert (= regexA (re.union (re.range "\u{00}" " ")(re.union (re.range "\u{22}" "\u{22}")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "<" "^")(re.union (re.range "a" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "s")(re.union (re.range "u" "z") (re.range "\u{7f}" "\u{ff}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
