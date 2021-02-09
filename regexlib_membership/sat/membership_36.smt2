;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (::|(((0:){5}(0|[fF]{4})|:(:[fF]{4})?):((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?|0)(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?|0)){3}))|([a-fA-F0-9]{1,4}:){7}([a-fA-F0-9]{1,4})|(:(:[a-fA-F0-9]{1,4}){1,6})|(([a-fA-F0-9]{1,4}:){1,6}:)|(([a-fA-F0-9]{1,4}:)(:[a-fA-F0-9]{1,4}){1,6})|(([a-fA-F0-9]{1,4}:){2}(:[a-fA-F0-9]{1,4}){1,5})|(([a-fA-F0-9]{1,4}:){3}(:[a-fA-F0-9]{1,4}){1,4})|(([a-fA-F0-9]{1,4}:){4}(:[a-fA-F0-9]{1,4}){1,3})|(([a-fA-F0-9]{1,4}:){5}(:[a-fA-F0-9]{1,4}){1,2}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00FF86::a:88"
(define-fun Witness1 () String (seq.++ "\xff" (seq.++ "8" (seq.++ "6" (seq.++ ":" (seq.++ ":" (seq.++ "a" (seq.++ ":" (seq.++ "8" (seq.++ "8" ""))))))))))
;witness2: "f:B:9:b45::c0d"
(define-fun Witness2 () String (seq.++ "f" (seq.++ ":" (seq.++ "B" (seq.++ ":" (seq.++ "9" (seq.++ ":" (seq.++ "b" (seq.++ "4" (seq.++ "5" (seq.++ ":" (seq.++ ":" (seq.++ "c" (seq.++ "0" (seq.++ "d" "")))))))))))))))

(assert (= regexA (re.union (str.to_re (seq.++ ":" (seq.++ ":" "")))(re.union (re.++ (re.union (re.++ ((_ re.loop 5 5) (str.to_re (seq.++ "0" (seq.++ ":" "")))) (re.union (re.range "0" "0") ((_ re.loop 4 4) (re.union (re.range "F" "F") (re.range "f" "f"))))) (re.++ (re.range ":" ":") (re.opt (re.++ (re.range ":" ":") ((_ re.loop 4 4) (re.union (re.range "F" "F") (re.range "f" "f")))))))(re.++ (re.range ":" ":") (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.range "0" "0"))))) ((_ re.loop 3 3) (re.++ (re.range "." ".") (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.range "0" "0"))))))))))(re.union (re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))(re.union (re.++ (re.range ":" ":") ((_ re.loop 1 6) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.union (re.++ ((_ re.loop 1 6) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) (re.range ":" ":"))(re.union (re.++ (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":")) ((_ re.loop 1 6) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.union (re.++ ((_ re.loop 2 2) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 5) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.union (re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.union (re.++ ((_ re.loop 4 4) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 3) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.++ ((_ re.loop 5 5) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 2) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
