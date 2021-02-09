;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((ht|f)tp(s?):\/\/)|(www\.[^ \[\]\(\)\n\r\t]+)|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})\/)([^ \[\]\(\),;&quot;'&lt;&gt;\n\r\t]+)([^\. \[\]\(\),;&quot;'&lt;&gt;\n\r\t])|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "68.8.81.058"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "1" (seq.++ "." (seq.++ "0" (seq.++ "5" (seq.++ "8" ""))))))))))))
;witness2: "\x1A089.33.8.286\x19"
(define-fun Witness2 () String (seq.++ "\x1a" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "3" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "\x19" "")))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (seq.++ "t" (seq.++ "p" "")))(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))(re.union (re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "'")(re.union (re.range "*" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff"))))))))) (re.++ (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.range "/" "/"))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "%")(re.union (re.range "*" "+")(re.union (re.range "-" ":")(re.union (re.range "<" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "^" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))))))))))) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "%")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ":")(re.union (re.range "<" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "^" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
