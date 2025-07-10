;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((ht|f)tp(s?):\/\/)|(www\.[^ \[\]\(\)\n\r\t]+)|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})\/)([^ \[\]\(\),;&quot;'&lt;&gt;\n\r\t]+)([^\. \[\]\(\),;&quot;'&lt;&gt;\n\r\t])|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "68.8.81.058"
(define-fun Witness1 () String (str.++ "6" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "." (str.++ "8" (str.++ "1" (str.++ "." (str.++ "0" (str.++ "5" (str.++ "8" ""))))))))))))
;witness2: "\x1A089.33.8.286\x19"
(define-fun Witness2 () String (str.++ "\u{1a}" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "3" (str.++ "3" (str.++ "." (str.++ "8" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "6" (str.++ "\u{19}" "")))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" "")))(re.++ (re.opt (re.range "s" "s")) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))))(re.union (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))) (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "'")(re.union (re.range "*" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}"))))))))) (re.++ (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.range "/" "/"))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "%")(re.union (re.range "*" "+")(re.union (re.range "-" ":")(re.union (re.range "<" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "^" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}"))))))))))))))) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "%")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ":")(re.union (re.range "<" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "^" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}"))))))))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
